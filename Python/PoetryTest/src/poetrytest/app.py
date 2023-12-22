import logging
from sub_module import sub_mod1
from sub_module import sub_mod2


def main():
    logging.basicConfig(
        level=logging.DEBUG,
        format="%(asctime)s %(levelname)s [%(process)s] %(filename)s:%(lineno)d - %(message)s",
    )
    print("这是一个main函数")
    sub_mod1.sub_fun1()
    sub_mod2.sub_fun2()


if __name__ == "__main__":
    main()
