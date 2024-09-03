package javagrpc.util;

import org.apache.commons.configuration2.Configuration;
import org.apache.commons.configuration2.PropertiesConfiguration;
import org.apache.commons.configuration2.builder.ConfigurationBuilderEvent;
import org.apache.commons.configuration2.builder.ReloadingFileBasedConfigurationBuilder;
import org.apache.commons.configuration2.builder.fluent.Parameters;
import org.apache.commons.configuration2.convert.LegacyListDelimiterHandler;
import org.apache.commons.configuration2.event.EventListener;
import org.apache.commons.configuration2.ex.ConfigurationException;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

// Apache Commons Config2的加载类
// 推荐使用 Configuration
@Deprecated
public final class ConfigLoader {

	// log4j2日志
	protected static final Logger log = LogManager.getLogger();

	// 单例对象 volatile + 双重检测机制来禁止指令重排
	private volatile static Configuration instance = null;

	// 懒加载的单例模式
	private ConfigLoader() {
	}

	@Deprecated
	public static Configuration getInstance(final String configFileName) throws ConfigurationException {
		if (instance == null) {
			synchronized (Configuration.class) {
				if (instance == null) {
					instance = getConfigurationInstance(configFileName);
				}
			}
		}
		return instance;
	}

	private static Configuration getConfigurationInstance(final String configFileName) throws ConfigurationException {

		Parameters params = new Parameters();
		// Create a builder that reads configuration from the property file and supports
		// reloading.
		ReloadingFileBasedConfigurationBuilder<PropertiesConfiguration> builder = new ReloadingFileBasedConfigurationBuilder<>(
				PropertiesConfiguration.class)
				.configure(params.fileBased().setFileName(configFileName)
						// Support comma separated list values. Legacy handler should read list the same
						// was
						// as commons-configuration did.
						.setListDelimiterHandler(new LegacyListDelimiterHandler(',')));

		// Listen to the events which are triggered every time configuration is
		// requested.
		builder.addEventListener(ConfigurationBuilderEvent.CONFIGURATION_REQUEST,
				new EventListener<ConfigurationBuilderEvent>() {
					@Override
					public void onEvent(ConfigurationBuilderEvent event) {
						// Check if configuration should be reloaded. This call also resets the
						// reloading controller so that
						// it could be used again to notice file changes.
						if (builder.getReloadingController().checkForReloading(null)) {
							log.info("Configuration [{}] has been updated...", configFileName);
						}
					}
				});

		// Test the configuration could be built
		return builder.getConfiguration();
	}
}
