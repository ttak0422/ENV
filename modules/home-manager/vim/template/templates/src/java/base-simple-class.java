{{_expr_:substitute(get(g:, 'sonic_license_header', ''), 'FILE_NAME', '{{_name_}}.java', 'g')}}

{{_lang_util_:package}}

public class {{_expr_:substitute('{{_name_}}', '\w\+', '\u\0', '')}} {
  {{_cursor_}}
}
