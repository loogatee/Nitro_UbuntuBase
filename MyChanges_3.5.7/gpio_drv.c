#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/platform_device.h>
#include <linux/gpio.h>
#include <linux/fs.h>
#include <linux/errno.h>
#include <asm/uaccess.h>
#include <linux/version.h>
#include <linux/types.h>
#include <linux/kdev_t.h>
#include <linux/device.h>
#include <linux/cdev.h>
 
#define GPIO_4_5    133
#define GPIO_2_1    193
#define GPIO_2_2    194
#define GPIO_2_3    195
#define GPIO_2_4    196
#define GPIO_7_13   45
#define GPIO_1_9    233
#define GPIO_7_11   43
#define GPIO_1_5    229
#define GPIO_ALL    1
 
static dev_t         first;     // Global variable for the first device number
static struct cdev   c_dev;     // Global variable for the character device structure
static struct class *cl;        // Global variable for the device class
 
static int init_result;
 
static ssize_t gpio_read( struct file* F, char *buf, size_t count, loff_t *f_pos )
{
    char buffer[10];
    int  t1,t2,t3,t4,t5,t6,t7,t8,t9;

    t1 = gpio_get_value(GPIO_4_5);  if(t1) t1=1;
    t2 = gpio_get_value(GPIO_2_1);  if(t2) t2=1;
    t3 = gpio_get_value(GPIO_2_2);  if(t3) t3=1;
    t4 = gpio_get_value(GPIO_2_3);  if(t4) t4=1;
    t5 = gpio_get_value(GPIO_2_4);  if(t5) t5=1;
    t6 = gpio_get_value(GPIO_7_13); if(t6) t6=1;
    t7 = gpio_get_value(GPIO_1_9);  if(t7) t7=1;
    t8 = gpio_get_value(GPIO_7_11); if(t8) t8=1;
    t9 = gpio_get_value(GPIO_1_5);  if(t9) t9=1;
    
 
    sprintf( buffer, "%d%d%d%d%d%d%d%d%d" , t1,t2,t3,t4,t5,t6,t7,t8,t9 );
 
    count = sizeof( buffer );
    if( copy_to_user( buf, buffer, count ) )
    {
        return -EFAULT;
    }
 
    if( *f_pos == 0 )
    {
        *f_pos += 10;
        return 10;
    }
    else
    {
        return 0;
    }
}

static void gpio_do_all( unsigned short  val )
{
    int   gval[9];

    if(( val & 0x0001 ) == 0 ) gval[0] = 0; else gval[0] = 1;
    if(( val & 0x0002 ) == 0 ) gval[1] = 0; else gval[1] = 1;
    if(( val & 0x0004 ) == 0 ) gval[2] = 0; else gval[2] = 1;
    if(( val & 0x0008 ) == 0 ) gval[3] = 0; else gval[3] = 1;
    if(( val & 0x0010 ) == 0 ) gval[4] = 0; else gval[4] = 1;
    if(( val & 0x0020 ) == 0 ) gval[5] = 0; else gval[5] = 1;
    if(( val & 0x0040 ) == 0 ) gval[6] = 0; else gval[6] = 1;
    if(( val & 0x0080 ) == 0 ) gval[7] = 0; else gval[7] = 1;
    if(( val & 0x0100 ) == 0 ) gval[8] = 0; else gval[8] = 1;

    gpio_set_value(GPIO_4_5,  gval[0]);
    gpio_set_value(GPIO_2_1,  gval[1]);
    gpio_set_value(GPIO_2_2,  gval[2]);
    gpio_set_value(GPIO_2_3,  gval[3]);
    gpio_set_value(GPIO_2_4,  gval[4]);
    gpio_set_value(GPIO_7_13, gval[5]);
    gpio_set_value(GPIO_1_9,  gval[6]);
    gpio_set_value(GPIO_7_11, gval[7]);
    gpio_set_value(GPIO_1_5,  gval[8]);
}
 
/*
 *     which GPIO:      buf[2]
 *                      Special case is when buf[2] == 1, which means GPIO_ALL
 *
 *     Value to write:  (unsigned short)buf[0]+buf[1]   
 *                      Normally, this is just a 1 (ON) or 0 (OFF), but special case is
 *                      when GPIO == GPIO_ALL.   In this case, bits are encoded as follows:
 *                              GPIO_4_5   bit 0
 *                              GPIO_2_1   bit 1
 *                              GPIO_2_2   bit 2
 *                              GPIO_2_3   bit 3
 *                              GPIO_2_4   bit 4
 *                              GPIO_7_13  bit 5
 *                              GPIO_1_9   bit 6
 *                              GPIO_7_11  bit 7
 *                              GPIO_1_5   bit 8
 *
 */
static ssize_t gpio_write( struct file* F, const char *buf, size_t count, loff_t *f_pos )
{
    unsigned short  *tptr;
    unsigned short   val;
    unsigned char    gpio_num;

    tptr     = (unsigned short *)buf;
    gpio_num = (unsigned char)buf[2];
    val      = *tptr;

    switch( gpio_num )
    {
        case GPIO_4_5:  gpio_set_value(GPIO_4_5,  (int)val);   break;
        case GPIO_2_1:  gpio_set_value(GPIO_2_1,  (int)val);   break;
        case GPIO_2_2:  gpio_set_value(GPIO_2_2,  (int)val);   break;
        case GPIO_2_3:  gpio_set_value(GPIO_2_3,  (int)val);   break;
        case GPIO_2_4:  gpio_set_value(GPIO_2_4,  (int)val);   break;
        case GPIO_7_13: gpio_set_value(GPIO_7_13, (int)val);   break;
        case GPIO_1_9:  gpio_set_value(GPIO_1_9,  (int)val);   break;
        case GPIO_7_11: gpio_set_value(GPIO_7_11, (int)val);   break;
        case GPIO_1_5:  gpio_set_value(GPIO_1_5,  (int)val);   break;
        case GPIO_ALL:  gpio_do_all(val);                      break;
    }

    return count;
}
 
static int gpio_open( struct inode *inode, struct file *file )
{
    return 0;
}
 
static int gpio_close( struct inode *inode, struct file *file )
{
    return 0;
}
 
static struct file_operations FileOps =
{
    .owner   = THIS_MODULE,
    .open    = gpio_open,
    .read    = gpio_read,
    .write   = gpio_write,
    .release = gpio_close,
};
 
static int init_gpio(void)
{
    init_result = alloc_chrdev_region( &first, 0, 1, "gpio_drv" );
 
    if( 0 > init_result )
    {
        printk( KERN_ALERT "gpio_drv:  Device Registration failed\n" );
        return -1;
    }
 
    if ( (cl = class_create( THIS_MODULE, "chardev" ) ) == NULL )
    {
        printk( KERN_ALERT "gpio_drv:  Class creation failed\n" );
        unregister_chrdev_region( first, 1 );
        return -1;
    }
 
    if( device_create( cl, NULL, first, NULL, "gpio_drv" ) == NULL )
    {
        printk( KERN_ALERT "gpio_drv:  Device creation failed\n" );
        class_destroy(cl);
        unregister_chrdev_region( first, 1 );
        return -1;
    }
 
    cdev_init( &c_dev, &FileOps );
 
    if( cdev_add( &c_dev, first, 1 ) == -1)
    {
        printk( KERN_ALERT "gpio_drv:  Device addition failed\n" );
        device_destroy( cl, first );
        class_destroy( cl );
        unregister_chrdev_region( first, 1 );
        return -1;
    }
 
    return 0;
}
 
void cleanup_gpio(void)
{
    cdev_del( &c_dev );
    device_destroy( cl, first );
    class_destroy( cl );
    unregister_chrdev_region( first, 1 );
}
 
module_init(init_gpio);
module_exit(cleanup_gpio);
 
MODULE_AUTHOR("jreed");
MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("BDAT GPIO Driver");
