#include <stdio.h>

#include "common.h"

int sub2() {
	printf("[DEBUG] [%s at line:%d] - sub2 function is run\n", __func__, __LINE__);
	printf("[DEBUG] [%s at line:%d] - sub2 函数运行 \n", __func__, __LINE__);
	printf("[DEBUG] [%s at line:%d] - sub2 関数実行 \n", __func__, __LINE__);
	return SUCCESS;
}
