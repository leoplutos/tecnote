if status is-interactive

	#系统判断，使用awk取得HOME路径，如果是c开头为Windows，其他开头为Linux
	set -g OS_TYPE 0
	set -g HOME_DIR_SUFFIX (echo ~ | awk -F/ '{print $2}')
	if test $HOME_DIR_SUFFIX = "c"
		set -g OS_TYPE 1
	end

	# fish_prompt函数用于定义命令行提示符
	function fish_prompt --description 'Write out the prompt'
		set -l last_pipestatus $pipestatus
		set -lx __fish_last_status $status
		set -l normal (set_color normal)
		set -q fish_color_status
		or set -g fish_color_status red

		# Color the prompt differently when we're root
		set -l color_cwd $fish_color_cwd
		set -l suffix '$'
		if functions -q fish_is_root_user; and fish_is_root_user
			if set -q fish_color_cwd_root
				set color_cwd $fish_color_cwd_root
			end
			set suffix '#'
		end
		set -l bold_flag --bold
		set -q __fish_prompt_status_generation; or set -g __fish_prompt_status_generation $status_generation
		if test $__fish_prompt_status_generation = $status_generation
			set bold_flag
		end
		set __fish_prompt_status_generation $status_generation
		set -l status_color (set_color $fish_color_status)
		set -l statusb_color (set_color $bold_flag $fish_color_status)
		set -l prompt_status (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)

		# 设定SUFFIX_ICON=NerdFont的图标
		if test "$OS_TYPE" -eq 0
			#Linux设定
			set -gx SUFFIX_ICON \uf31b\u00a0\[fish\]
			set -gx LOCAL_IP_ADDRESS (hostname -I | awk '{print$1}')
		else
			#Windows设定
			set -gx SUFFIX_ICON \ue70f\u00a0\[fish\]
			set -gx LOCAL_IP_ADDRESS (netsh interface ip show address "以太网" | findstr "IP Address" | awk '{print$3}')
		end
		printf '%s%s%s@%s%s%s%s%s%s '\
				(set_color yellow)$SUFFIX_ICON \
				(set_color green)\[$LOCAL_IP_ADDRESS\] \
				(set_color magenta)$USER \
				(set_color magenta)$hostname \
				(set_color normal): \
				(set_color yellow)(pwd)\n \
				$prompt_status \
				(set_color blue)$suffix \
				(set_color normal)
	end

	#键进入vi模式
	function enter_vim_mode
		fish_vi_key_bindings --no-erase insert
	end
	#回到普通模式
	function enter_default_mode
		fish_default_key_bindings
	end
	#设定vi模式的指示器
	#function fish_mode_prompt
	#	switch $fish_bind_mode
	#		case default
	#			echo -en "\e[2 q"
	#			set_color --background 78a2f3
	#			set_color 000010
	#			echo '[NORMAL]'
	#		case insert
	#			echo -en "\e[6 q"
	#			set_color --background ffff00
	#			set_color 000010
	#			echo '[INSERT]'
	#		case replace_one
	#			echo -en "\e[4 q"
	#			set_color --background d70000
	#			set_color ffffff
	#			echo '[REPLACE]'
	#		case replace
	#			echo -en "\e[4 q"
	#			set_color --background d70000
	#			set_color ffffff
	#			echo '[REPLACE]'
	#		case visual
	#			echo -en "\e[2 q"
	#			set_color --background 00ff87
	#			set_color 000010
	#			echo '[VISUAL]'
	#		case '*'
	#			echo -en "\e[2 q"
	#			set_color --bold red
	#			echo '[?]'
	#	end
	#	set_color normal
	#end

	if test "$OS_TYPE" -eq 0
		#Linux设定
		set personal_workspace ~/work/lch/workspace
		set personal_log ~/work/lch/log
	else
		#Windows设定
		set personal_workspace /d/WorkSpace
		set personal_log /d/WorkSpace/log
	end
	function ll
		ls -hl --full-time --time-style=long-iso --color=auto $argv
	end
	function lla
		ls -hal --full-time --time-style=long-iso --color=auto $argv
	end
	function llt
		ls -htl --full-time --time-style=long-iso --color=auto $argv
	end
	function cdw
		cd $personal_workspace $argv
	end
	function cdl
		cd $personal_log $argv
	end
	alias lg="lazygit"
	if test "$OS_TYPE" -eq 0
		#Linux设定
		function vimf
			vim -u ~/work/lch/rc/vimrc/.vimrc $argv --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1"
		end
		function vimc
			vim -u ~/work/lch/rc/vimrc/.vimrc $argv --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1 | let g:g_lsp_type = 3"
		end
		function vimv
			vim -u ~/work/lch/rc/vimrc/.vimrc $argv --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1 | let g:g_front_dev_type = 1"
		end
		function nvimf
			env TERM=wezterm nvim -u ~/work/lch/rc/nvimrc/init.lua $argv --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1"
		end
		function nvimc
			env TERM=wezterm nvim -u ~/work/lch/rc/nvimrc/init.lua $argv --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1 | let g:g_lsp_type = 3"
		end
		function nvimv
			env TERM=wezterm nvim -u ~/work/lch/rc/nvimrc/init.lua $argv --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1 | let g:g_front_dev_type = 1"
		end
	else
		#Windows设定
		function vimf
			vim $argv --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1"
		end
		function vimc
			vim $argv --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1 | let g:g_lsp_type = 3"
		end
		function vimv
			vim $argv --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1 | let g:g_front_dev_type = 1"
		end
		function gvimf
			gvim $argv --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1"
		end
		function gvimc
			gvim $argv --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1 | let g:g_lsp_type = 3"
		end
		function gvimv
			gvim $argv --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1 | let g:g_front_dev_type = 1"
		end
		function nvimf
			nvim $argv --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1"
		end
		function nvimc
			nvim $argv --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1 | let g:g_lsp_type = 3"
		end
		function nvimv
			nvim $argv --cmd "let g:g_use_lsp = 1 | let g:g_use_dap = 1 | let g:g_front_dev_type = 1"
		end
	end

	#颜色自定义
	#命令颜色，比如echo
	set fish_color_command 64afef
	#关键字颜色，比如if
	set fish_color_keyword 569cd6
	#字符串颜色，比如"abc"
	set fish_color_quote 809980
	#重定向颜色，比如>/dev/null
	set fish_color_redirection ff9e64
	#分隔符，比如;&
	set fish_color_end cdcdff
	#错误
	set fish_color_error ff2d13
	#普通命令参数
	set fish_color_param 9cdcfe
	#文件名参数
	set fish_color_valid_path d4d4b0 --underline
	#以“-”开头的选项，直到第一个“--”参数
	set fish_color_option 96e072
	#注释
	set fish_color_comment 5f6167
	#vi模式下的选择内容
	set fish_color_selection --background 2e3c64
	#参数扩展运算符，比如*和~
	set fish_color_operator f39c12
	#转移字符串，，比如\n和\x70
	set fish_color_escape f39c12

end
