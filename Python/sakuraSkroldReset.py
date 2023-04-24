# 这是一个python的脚本，用来复原Sakura Editor的grep替换操作
# 在Sakura Editor中，如果使用了grep替换操作后，会生成一个扩展名为.skrold的文件
# 这个脚本的目的就是找到所有扩展名为.skrold的文件并且复原到源文件
# 比如：a.txt.skrold的内容 复制到 a.txt
import os

target_dir = 'D:\path\target'
path = os.getcwd()
output_log = os.path.join(path, 'sakuraSkroldReset.log')
print(f" output_log:{output_log}")

log_file = open(output_log, 'w', encoding='utf-8')

count = 1
for current_dir, sub_dir, files_list in os.walk(target_dir):
	if ('.git' in current_dir):
		#[.git]路径除外
		continue
	for file in files_list:
		file_name, file_extension = os.path.splitext(file)

		if (file_extension == '.skrold'):
			#log_file.write(f"number:{count}	file_path:{current_dir}	file_name:{file_name}	file_extension:{file_extension}\n")

			fromFile = os.path.join(current_dir, file_name+file_extension);
			toFile = os.path.join(current_dir, file_name);

			# 写入文件流
			output_file = open(toFile, 'w', encoding='utf-8', newline="\n")
			  
			# 读取文件流
			with open(fromFile, 'r', encoding='utf-8') as scan:
				output_file.write(scan.read())

			# Closing the output file
			output_file.close()

			log_file.write(f"from:{fromFile}　⇒　to:{toFile}\n")

			count += 1

log_file.close