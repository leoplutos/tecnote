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
end
