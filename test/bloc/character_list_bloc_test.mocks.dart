// Mocks generated by Mockito 5.4.2 from annotations
// in rick_and_morty_challenge/test/bloc/character_list_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:rick_and_morty_challenge/services/character_service.dart'
    as _i3;
import 'package:rick_and_morty_challenge/utils/http_request.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeJResponse_0 extends _i1.SmartFake implements _i2.JResponse {
  _FakeJResponse_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [CharacterService].
///
/// See the documentation for Mockito's code generation for more information.
class MockCharacterService extends _i1.Mock implements _i3.CharacterService {
  MockCharacterService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.JResponse> getCharacters(
          {String? url = r'https://rickandmortyapi.com/api/character'}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getCharacters,
          [],
          {#url: url},
        ),
        returnValue: _i4.Future<_i2.JResponse>.value(_FakeJResponse_0(
          this,
          Invocation.method(
            #getCharacters,
            [],
            {#url: url},
          ),
        )),
      ) as _i4.Future<_i2.JResponse>);
  @override
  _i4.Future<_i2.JResponse> searchCharacter(String? name) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchCharacter,
          [name],
        ),
        returnValue: _i4.Future<_i2.JResponse>.value(_FakeJResponse_0(
          this,
          Invocation.method(
            #searchCharacter,
            [name],
          ),
        )),
      ) as _i4.Future<_i2.JResponse>);
}
