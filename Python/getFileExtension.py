# 这是一个python的脚本，用来列出一个路径下文件的所有扩展名
# 目标1：出力每个文件的路径，名称，扩展名
# 目标2：统计所有扩展名，出力
# 目标3：check所有文件的换行符，出力(这个例子统计有换行符为CRLF的文件)
import os

target_dir = 'D:\path\target'
path = os.getcwd()
output_log = os.path.join(path, 'getFileExtension.log')
print(f" output_log:{output_log}")
extension_list = []
crlf_check_file_list = ['.sh','.ctl','.h','.in','.pc','.c']
crlf_result_file_list = []

log_file = open(output_log, 'w')

count = 1
for current_dir, sub_dir, files_list in os.walk(target_dir):
    if ('.git' in current_dir):
        #[.git]路径除外
        continue
    for file in files_list:
        file_name, file_extension = os.path.splitext(file)
        #print(f"number:{count}    file_path:{current_dir}    file_name:{file_name}    file_extension:{file_extension}")
        # 目标1：出力每个文件的路径，名称，扩展名
        log_file.write(f"number:{count}    file_path:{current_dir}    file_name:{file_name}    file_extension:{file_extension}\n")
        # 目标2：统计所有扩展名，出力
        if (file_extension in extension_list):
            pass
        else:
            extension_list.append(file_extension)
        # 目标3：check所有文件的换行符，出力(这个例子统计有换行符为CRLF的文件)
        if (file_extension in crlf_check_file_list):
            with open(os.path.join(current_dir, file),'rb') as f:
                for line in f:
                    if ('\r\n' in line.decode('utf-8')):
                        crlf_result_file_list.append(os.path.join(current_dir, file))
                        break
            f.close
        count += 1

# 目标2：统计所有扩展名，出力
log_file.write('\n')
log_file.write('----------------------------------------------\n')
log_file.write('\n'.join(extension_list))

# 目标3：check所有文件的换行符，出力(这个例子统计有换行符为CRLF的文件)
log_file.write('\n')
log_file.write('----------------------------------------------\n')
log_file.write('\n'.join(crlf_result_file_list))

log_file.close
