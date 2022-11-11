{{_expr_:substitute(get(g:, 'sonic_license_header', ''), 'FILE_NAME', '{{_name_}}.java', 'g')}}
{{_lang_util_:package}}

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequiredArgsConstructor
public class {{_expr_:substitute('{{_name_}}', '\w\+', '\u\0', '')}} {
  {{_cursor_}}
}
