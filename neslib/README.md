* Specific feature
    * init/end/nmi/irq_handler
        * If you want to call functions before call main(), you can export these function
          using ".condes hogehoge, 0". This library automatically call these function.
        * If you want to call functions after call main(), you can export these function
          using ".condes hogehoge, 1". This library automatically call these function.
        * If you want to call functions when nmi happen, you can export these function
          using ".condes hogehoge, 2". This library automatically call these function.
        * If you want to call functions when irq happen, you can export these function
          using ".condes hogehoge, 3". This library automatically call these function.
