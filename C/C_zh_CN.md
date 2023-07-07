# C语言相关

## 1.常用函数

#### 1-1.环境变量取得
需要导入stdlib.h库
```c
#include <stdlib.h>

bool b_debug_flg = false;
char *env_debug = getenv("DEBUG_FLG");
if ((env_debug != NULL) && (*env_debug == '1')) {
	b_debug_flg = true;
} else {
	b_debug_flg = false;
}
```

#### 1-2.ECPG打印sqlca结果
```c
if (b_debug_flg) {
	printf("[DEBUG][%s at line:%d] - sqlcode:[%ld] sqlstate:[%s] sqlerrm.sqlerrmc:[%s]\n", __func__, __LINE__, sqlca.sqlcode, sqlca.sqlstate, sqlca.sqlerrm.sqlerrmc);
}
```

#### 1-3.atoi函数（字符串转int）
```c
// 需要导入#include <stdlib.h>
char c_cnt[5+1] = "12345";
int i_cnt;
// 转换
i_cnt = atoi(c_cnt);
printf("转换后i_cnt : [%d]\n", i_cnt);
```

#### 1-4.sprintf函数（int转字符串）
```
int i_size = 67890;
char c_size[5+1];
// 转换
sprintf(c_size, "%d", i_size);
printf("转换后c_size : [%s]\n", c_size);
```

#### 1-5.字符串补空格
```
char c_target[5+1] = "abc";
// 不满5位补空格
sprintf(c_target, "%-5s", c_target);
printf("补空格后c_target : [%s]\n", c_target);
```

#### 1-6.字符串解构/截取
```c
// 例子1
char c_input1[300+1] = "2023-04-19 17:01:52  - table name : t_test_table1";
char c_output_date[20+1];
char c_output_time[20+1];
char c_output_tablename[20+1];
// 按照规则解构
sscanf(c_input1, "%s %s  - table name : %s", c_output_date, c_output_time, c_output_tablename);
printf("解构后 c_output_date:[%s] c_output_time:[%s] c_output_tablename:[%s]\n", c_output_date, c_output_time, c_output_tablename);
```
```c
// 例子2
char * c_input2 = "table name : t_test_table2";
char c_output_tablename2[20+1];
// 按照规则解构
sscanf(c_input2, "table name : %s", c_output_tablename2);
printf("解构后 c_output_tablename2:[%s]\n", c_output_tablename2);
```

**其他解构方法：**  
```c
scanf("%4[^,],%4[^,],%79[^,],%d", sem, type, title, &value)
```
``%4[^,]`` 表示最多读取四个字符或直到遇到逗号  


#### 1-7.-DDEBUG编译标记
大家都有利用输出函数如printf来帮助我们调试程序的经历，这是一种比较原始的程序调试辅助方法，在Linux下也可以为我们所用。不过这种方法有一个明显的缺点，就是在调试完后我们必须注释或删除掉这些辅助代码。Linux C提供了 -DDEBUG 这个编译标记来定义DEBUG这个符号，借助于该符号，我们可以在应用程序中添加额外代码并根据需要决定执行与否。
```c
#include<stdio.h>
int main()
{
#ifdef DEBUG
    printf("Debug output....../n");
#endif
printf("Main function ended!/n";
}
```
在编译的时候加上 -DDEBUG 参数编译的话，就会打印出[Debug output]，不加则不会。  
编译运行（不加调试信息）：
```bash
$ gcc -o dtest dtest.c
$ ./dtest
Main function ended!
```
编译运行（加调试信息）：
```bash
$ gcc -o dtest -DDEBUG dtest.c
$ ./dtest
Debug output......
Main function ended!
```

#### 1-8.二维字符串数组的参数使用
```c
void test_function(char *str[], int n) {
	for (int i = 0; i < n; i++) {
		printf("%s \n", str[i]);
	}
}

int main(int argc, char *argv[]) {
	char *pstr[3] = {"cc", "bb", "dd"};
	test_function(pstr, 3);
	return 0;
}
```

#### 1-9.二维和三维度字符串数组的动态开辟空间

**二维数组**  
```
char **in_sqlcond_data;
in_sqlcond_data = (char **)malloc(sizeof(char *) * count);
for (i = 0; i < count; i++) {
	in_sqlcond_data[i] = (char *)malloc(sizeof(char) * 800 + 1);
}
strcpy(in_sqlcond_data[0], "aaaaa");
strcpy(in_sqlcond_data[1], "bbbbb");
```

**三维数组**  
```
char ***out_result_data;
out_result_data = (char ***)malloc(sizeof(char **) * count1);
for (i = 0; i < count1; i++) {
	out_result_data[i] = (char **)malloc(sizeof(char *) * count2);
	for (j = 0; j < count2; j++) {
		out_result_data[i][j] = (char *)malloc(sizeof(char) * 800 + 1);
	}
}
```

#### 1-10.csv分割的函数

**调用**  
```
char c_separator[6][800 + 1];
memset(c_separator, 0, sizeof(c_separator[0][0]) * 6 * (800 + 1));
i_retCode = com_divCSV(c_read_line_buf, sizeof(c_separator[0]), 6, c_separator);
```

**分割函数**  
```
int com_divCSV(char *c_iString, int i_iStrLen, int i_iCount, char *c_oString) {
	int i;
	int i_len;
	int i_strPos = 0;
	int i_strNum = 0;
	char *c_pStr;

	c_pStr = (char *)c_oString;

	i_len = strlen(c_iString);
	for (i = 0; i < i_len; i++) {
		if (c_iString[i] == ',') {
			strncpy(c_pStr + i_strNum * i_iStrLen, &c_iString[i_strPos], i - i_strPos);
			*(c_pStr + i_strNum * i_iStrLen + i - i_strPos) = 0x00;

			i_strNum++;
			if (i_strNum == i_iCount) {
				return FAILED;
			}
			i_strPos = i + 1;
		}
	}
	strncpy(c_pStr + i_strNum * i_iStrLen, &c_iString[i_strPos], i - i_strPos);
	*(c_pStr + i_strNum * i_iStrLen + i - i_strPos) = 0x00;
	i_strNum++;
	if (i_strNum == i_iCount) {
		return SUCCESS;
	} else {
		return FAILED;
	}
}
```

## 2.终端输出颜色
1：粗体  
31：红色  
33：黄色  
0：重置
```c
#define  TER_ERROR  "\e[1;31m"
#define  TER_WARN   "\e[1;33m"
#define  TER_RESET  "\e[0m"

printf(TER_WARN "[WARN][%s at line:%d]" TER_RESET "这是警告\n", __func__, __LINE__);
fprintf(stderr, TER_ERROR "[ERROR][%s at line:%d]" TER_RESET "这是错误\n", __func__, __LINE__);
```

## 3.其他

### undefined reference to 错误
在使用gcc编译时，如果使用了静态库（.a文件），发生了[undefined reference to]错误的话，
是因为编译的时候没有把静态库（.a文件）放在命令最后。  
比如，如下编译会发生错误  
```
gcc -o main.exe libtest.a main.o
```
修改为如下即可
```
gcc -o main.exe main.o libtest.a
```

## 日志库：log.c
* [log.c](https://github.com/rxi/log.c)  
如果想打印的内容带颜色，编译的时候需要加上参数 ``-DLOG_USE_COLOR``  

## 单元测试和Mock库：Cmockery
* [Cmockery](https://github.com/google/cmockery)  


