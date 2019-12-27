
---

### usb.h

1 addition I added:

     < extern int usb_device_supports_lpm(struct usb_device *udev);


Might be stuff I added to get xhci USB controller working better.


---

### nitro6xBD_defconfig   vs.   nitrogen6x_defconfig

      < # CONFIG_KEYBOARD_GPIO is not set    ( I unset this )
      --------
      > CONFIG_KEYBOARD_GPIO=y


      < CONFIG_SND_PCI=y                     ( I set this )
      --------
      > # CONFIG_SND_PCI is not set


( I added all these at the bottom )

     < CONFIG_USB_G_MULTI=m
     < CONFIG_USB_G_MULTI_RNDIS=y
     < # CONFIG_USB_G_MULTI_CDC is not set
     < CONFIG_NETFILTER=y
     < CONFIG_IP_NF_IPTABLES=m
     < CONFIG_NF_CONNTRACK=m
     < CONFIG_NF_CONNTRACK_IPV4=m
     < CONFIG_NF_NAT=m
     < CONFIG_IP_NF_NAT=m
     < CONFIG_IP_NF_TARGET_MASQUERADE=m
     < CONFIG_IP_NF_FILTER=m
     < CONFIG_IP_NF_MANGLE=m
     < CONFIG_USB_SERIAL=y
     < CONFIG_USB_SERIAL_FTDI_SIO=y
     < CONFIG_USB_SERIAL_PL2303=y
     < CONFIG_USB_XHCI_HCD=y
     < CONFIG_IMX_PCIE_EP_MODE_IN_EP_RC_SYS=y
     < CONFIG_IMX_PCIE_RC_MODE_IN_EP_RC_SYS=y
     < CONFIG_LEDS_GPIO=y
     < CONFIG_USB_ACM=y

---

### scsi.c


    <    if (sdev->skip_vpd_pages)
    <        goto fail;
    < 

I added this small piece.   Trying to improve the xhci USB stuff.

This code is now in the mainline scsi.c.

---

### multi.c

Changes related to:

      #define  N_SERIAL_PORTS    2

**N_SERIAL_PORTS 3** did not work due to resource limitation.

---

### imx6q-pinfunc.h

Added this:

     #define MX6Q_PAD_EIM_D28__UART2_DTE_CTS_B         0x0c4 0x3d8 0x924 0x4 0x0
     #define MX6Q_PAD_EIM_D28__UART2_DTE_RTS_B         0x0c4 0x3d8 0x000 0x4 0x0

Added this:

     #define MX6Q_PAD_EIM_D29__UART2_DTE_RTS_B         0x0c8 0x3dc 0x000 0x4 0x0
     #define MX6Q_PAD_EIM_D29__UART2_DTE_CTS_B         0x0c8 0x3dc 0x924 0x4 0x1


Original:

     #define MX6Q_PAD_ENET_RX_ER__USB_OTG_ID         0x1d8 0x4ec 0x000 0x0 0x0

Mine:

     #define MX6Q_PAD_ENET_RX_ER__USB_OTG_ID         0x1d8 0x4ec 0x004 0x0 0xff0d0100

<br>
Original:

     #define MX6Q_PAD_GPIO_1__USB_OTG_ID             0x224 0x5f4 0x000 0x3 0x0

Mine:

     #define MX6Q_PAD_GPIO_1__USB_OTG_ID             0x224 0x5f4 0x004 0x3 0xff0d0101

---

### imx6q-nitrogen6x.dts

I removed all of **gpio-keys{ };**

---


### hub.c

Looks like more changes geared towards the xhci usb thing.

Have 1 change which didn't make it into 3.16 linux mainline.   Surely
found this on the web somewhere.

In routine **usb_disable_lpm()**:

    if (!udev || udev->state < USB_STATE_UNAUTHENTICATED || !udev->parent ||
                        udev->speed != USB_SPEED_SUPER ||
                        !udev->lpm_capable)
               return 0;

The **USB_STATE_UNAUTHENTICATED** test is not in the mainline.

google searching on that showed a post by Sarah Sharp that this is not the appropriate
place for the check.

---

### hcd.c


again....more changes geared towards the xhci usb thing.

Added 1 line in routine:  **register_root_hub()**

     usb_dev->lpm_capable = usb_device_supports_lpm(usb_dev);

Looks like this line did not get into the 3.16 release.

---

### drivers_gpio_Makefile


    obj-$(CONFIG_OF_GPIO)		+= gpiolib-of.o gpio_drv.o


Added, so that gpio_drv.o is built

---


### gpio_drv.c


My GPIO driver

---

### imx6q.dtsi

mine:

      MX6Q_PAD_GPIO_5__I2C3_SCL   0x4001b0b1
      MX6Q_PAD_GPIO_16__I2C3_SDA  0x4001b0b1

original:

      MX6Q_PAD_GPIO_5__I2C3_SCL   0x4001b8b1
      MX6Q_PAD_GPIO_16__I2C3_SDA  0x4001b8b1

I believe I'm turning OFF the I2C functionality, so that I can treat the pins purely as GPIO


---











