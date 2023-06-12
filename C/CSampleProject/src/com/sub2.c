#include <stdio.h>

#include "common.h"
#include "log.h"

int sub2() {
	log_debug("sub2 function is run");
	log_trace("sub2 函数运行");
	log_info("sub2 関数実行");
	return SUCCESS;
}
