import os
import configparser


# 配置文件读取类（单例模式）
class Config:

    # 单例
    __instance = None
    # 初始化标记
    __initialized = False

    # __new__是一个静态方法，用于创建类的新实例
    def __new__(cls, *args, **kwargs):
        if not cls.__instance:
            cls.__instance = super(Config, cls).__new__(cls, *args, **kwargs)
            # 标记实例尚未初始化
            cls.__instance.__initialized = False
        return cls.__instance

    def __init__(self):
        if not self.__initialized:
            # 标记实例已初始化
            self.__initialized = True

            # 配置多来源
            # 1.config.{env.PYTHON_ENVIRONMENT}.ini
            # 2.OS的环境变量

            # 读取环境变量，默认dev
            python_env = os.environ.get('PYTHON_ENVIRONMENT', 'dev').lower()
            # 工程根目录
            root_path = os.getcwd()
            # 配置文件名
            config_filenm = f"config.{python_env}.ini"

            # 初始化config
            self.config = configparser.ConfigParser(
                interpolation=configparser.BasicInterpolation()
            )
            # 读取配置文件
            real_path = os.path.join(
                root_path,
                config_filenm,
            )
            self.config.read(real_path, encoding='utf-8')

            # 读取所有环境变量，合并到一个config中
            self.config.add_section("ENV")
            for key, value in os.environ.items():
                self.config.set("ENV", key, value)

    def get_str_value(self, section: str, key: str, default_value: str = "") -> str:
        ret = default_value
        try:
            ret = self.config.get(section, key)
        except:
            ret = default_value
        return ret

    def get_int_value(self, section: str, key: str, default_value: int = 0) -> int:
        ret = default_value
        try:
            ret = self.config.getint(section, key)
        except:
            ret = default_value
        return ret

    def get_boolean_value(self, section: str, key: str, default_value: bool) -> bool:
        ret = default_value
        try:
            ret = self.config.getboolean(section, key)
        except:
            ret = default_value
        return ret

    def get_float_value(
        self, section: str, key: str, default_value: float = 0
    ) -> float:
        ret = default_value
        try:
            ret = self.config.getfloat(section, key)
        except:
            ret = default_value
        return ret
