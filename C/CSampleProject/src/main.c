#include <stdio.h>

#include "common.h"
#include "log.h"

int main(int argc, char *argv[]) {
	log_set_level(0);
	log_set_quiet(0);

	FILE *info_log_file, *debug_log_file;
	info_log_file = fopen("./log_info.log", "ab");
	if (info_log_file == NULL) {
		return FAILED;
	}
	debug_log_file = fopen("./log_debug.log", "ab");
	if (debug_log_file == NULL) {
		return FAILED;
	}
	log_add_fp(info_log_file, LOG_INFO);
	log_add_fp(debug_log_file, LOG_DEBUG);

	char c_show_msg[100 + 1] = "Hello!こんにちは!你好!안녕하세요!";
	// printf("[DEBUG] [%s at line:%d] - c_show_msg:[%s] \n", __func__, __LINE__, c_show_msg);
	log_debug(c_show_msg);

	int i_retCode = SUCCESS;

	log_info("sub1开始。");
	i_retCode = sub1(10, 1, 2, 1.0, 2.0, 3.0, "aaa", "bbb", "ccc", "ddd", "あいうえお");
	log_warn("sub1结束。结果：[%d]。", i_retCode);
	log_debug("sub2开始。");
	i_retCode = sub2();
	log_error("sub2结束。结果：[%d]。", i_retCode);

	fclose(info_log_file);
	fclose(debug_log_file);
	return i_retCode;
}
