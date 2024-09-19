#!/usr/bin/env python
# -*- coding: utf-8 -*-

import logging


def sub_fun2(param: int) -> tuple[int, int]:
    logging.debug("sub2 function is run.")
    b, c = 1, 2
    ret = (param + b) * c
    logging.info(f"计算结果为: {ret}")
    return ret, 0
