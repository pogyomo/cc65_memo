* interrupt
    * startup.s
        * Init system, then use init_hander and call main
        * User should define main label for main process
        * After main, use end_handler and reset system
        * See rutime/handler.s
    * interrupt.s
        * When nmi or irq was happen, use nmi_handler or irq_handler
        * See rutime/handler.s
    * vectors.s
        * Define interrupt vector for startup.s and interrupt.s


* rumtime
    * handler.s
        * Call function in function table that made by condes in \*.cfg's feature


* Segments that need for this library
    * VECTORS : For interrupt
    * HEADER  : For iNES header
