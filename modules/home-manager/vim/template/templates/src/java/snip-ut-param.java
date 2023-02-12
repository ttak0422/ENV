@ParameterizedTest(name = "{0}")
@MethodSource("provider_{{_input_:testName}}")
void {{_input_:testName}}(
  String displayName,
  {{_cursor_}}
  ) {
  // arrange:

  // act:

  // assert:
}

static Stream<Arguments> provider_{{_input_:testName}}() {
  return Stream.of(
    arguments.of(
    ),
    arguments.of(
    )
  );
}
