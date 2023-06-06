#include <stdio.h>

#include "common.h"

int main(int argc, char *argv[]) {
	char c_show_msg[100 + 1] = "Hello!こんにちは!你好!안녕하세요!";

	printf("[DEBUG] [%s at line:%d] - c_show_msg:[%s] \n", __func__, __LINE__, c_show_msg);

	int i_retCode = SUCCESS;

	printf("[DEBUG] [%s at line:%d] - sub1开始。\n", __func__, __LINE__);
	i_retCode = sub1(10, 1, 2, 1.0, 2.0, 3.0, "aaa", "bbb", "ccc", "ddd", "あいうえお");
	printf("[DEBUG] [%s at line:%d] - sub1结束。结果：[%d]。\n", __func__, __LINE__, i_retCode);
	printf("[DEBUG] [%s at line:%d] - sub2开始。\n", __func__, __LINE__);
	i_retCode = sub2();
	printf("[DEBUG] [%s at line:%d] - sub2结束。结果：[%d]。\n", __func__, __LINE__, i_retCode);

	return i_retCode;
}
