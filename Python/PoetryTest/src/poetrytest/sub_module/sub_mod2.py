#!/usr/bin/env python
# -*- coding: utf-8 -*-

import logging


def sub_fun2():
    logging.debug("sub2 function is run.")
    data = [
        ('Apple', 'Fruit'),
        ('Beetroot', 'Vegetable'),
        ('Carrot', 'Vegetable'),
        ('Date', 'Fruit'),
        ('Eggplant', 'Vegetable'),
        ('Fig', 'Fruit'),
    ]
    logging.info(f"sub2 data:{data}")
    return 2
