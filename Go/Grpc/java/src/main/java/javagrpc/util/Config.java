package javagrpc.util;

import org.apache.commons.configuration2.CompositeConfiguration;
import org.apache.commons.configuration2.Configuration;
import org.apache.commons.configuration2.EnvironmentConfiguration;
import org.apache.commons.configuration2.PropertiesConfiguration;
import org.apache.commons.configuration2.builder.ReloadingFileBasedConfigurationBuilder;
import org.apache.commons.configuration2.builder.fluent.Parameters;
import org.apache.commons.configuration2.convert.LegacyListDelimiterHandler;
import org.apache.commons.configuration2.ex.ConfigurationException;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

// Apache Commons Config2的加载类
public final class Config {

	// log4j2日志
	protected static final Logger log = LogManager.getLogger();

	// 单例对象 volatile + 双重检测机制来禁止指令重排
	private volatile static Configuration instance = null;

	// 懒加载的单例模式
	private Config() {
	}

	public static Configuration getInstance() throws ConfigurationException {
		if (instance == null) {
			synchronized (Configuration.class) {
				if (instance == null) {
					instance = getConfigurationInstance();
				}
			}
		}
		return instance;
	}

	// 配置多来源
	// 1.config.properties
	// 2.config.{env.JAVA_ENVIRONMENT}.properties
	// 3.OS的环境变量
	private static Configuration getConfigurationInstance() throws ConfigurationException {

		// 来源3.OS的环境变量
		EnvironmentConfiguration env_properties = new EnvironmentConfiguration();
		String javaEnv = env_properties.getString("JAVA_ENVIRONMENT", "dev");

		// 来源1.config.properties
		String fileName = "config.properties";
		Parameters params = new Parameters();
		ReloadingFileBasedConfigurationBuilder<PropertiesConfiguration> builder = new ReloadingFileBasedConfigurationBuilder<>(
				PropertiesConfiguration.class)
				.configure(params.fileBased().setFileName(fileName)
						.setListDelimiterHandler(new LegacyListDelimiterHandler(',')));
		Configuration config_properties = builder.getConfiguration();

		// 来源2.config.{env.JAVA_ENVIRONMENT}.properties
		fileName = String.format("config.%s.properties", javaEnv);
		params = new Parameters();
		builder = new ReloadingFileBasedConfigurationBuilder<>(
				PropertiesConfiguration.class)
				.configure(params.fileBased().setFileName(fileName)
						.setListDelimiterHandler(new LegacyListDelimiterHandler(',')));
		Configuration config_env_properties = builder.getConfiguration();

		// 组合不同来源的配置
		CompositeConfiguration compositeConfig = new CompositeConfiguration();
		compositeConfig.addConfiguration(config_properties);
		compositeConfig.addConfiguration(config_env_properties);
		compositeConfig.addConfiguration(env_properties);
		return compositeConfig;
	}
}
