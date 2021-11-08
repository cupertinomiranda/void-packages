#
# This helper is for templates using GNU configure scripts.
#
do_configure() {
	export > /tmp/export_gnu_configure

	if [ -f config.sub ]; then
		sed 's/arc | arceb/arc | arceb | arc64/' config.sub > /tmp/config.sub
		cp /tmp/config.sub ./config.sub
	fi
	if [ -f build-aux/config.sub ]; then
		sed 's/arc | arceb/arc | arceb | arc64/' build-aux/config.sub > /tmp/config.sub
		cp /tmp/config.sub ./build-aux/config.sub
	fi

	: ${configure_script:=./configure}

	local config_sub_file=${configure_script/configure/config.sub}
	echo ${config_sub_file} > /tmp/list
	if [ -f ${config_sub_file} ]; then
		sed 's/arc | arceb/arc | arceb | arc64/' ${config_sub_file} > /tmp/config1.sub
		cp /tmp/config1.sub ${config_sub_file}
	fi


	export lt_cv_sys_lib_dlsearch_path_spec="/usr/lib64 /usr/lib32 /usr/lib /lib /usr/local/lib"
	${configure_script} ${configure_args}
}

do_build() {
	: ${make_cmd:=make}

	export lt_cv_sys_lib_dlsearch_path_spec="/usr/lib64 /usr/lib32 /usr/lib /lib /usr/local/lib"
	export > /tmp/export_gnu_build

	${make_cmd} ${makejobs} ${make_build_args} ${make_build_target}
}

do_check() {
	if [ -z "$make_cmd" ] && [ -z "$make_check_target" ]; then 
		if make -q check 2>/dev/null; then
			:
		else
			if [ $? -eq 2 ]; then
				msg_warn 'No target to "make check".\n'
				return 0
			fi
		fi
	fi

	: ${make_cmd:=make}
	: ${make_check_target:=check}

	${make_check_pre} ${make_cmd} ${makejobs} ${make_check_args} ${make_check_target}
}

do_install() {
	: ${make_cmd:=make}
	: ${make_install_target:=install}

	${make_cmd} DESTDIR=${DESTDIR} ${make_install_args} ${make_install_target}
}
