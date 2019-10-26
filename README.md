# erliza
Yet another Erlang Eliza, natural language processing conversation program, focused on performance 
and extensible conversation composition.

The original lexer and parser credit goes to https://github.com/edinhui/eliza.git. Unlike other many eliza implementations,
having parsers for scripts provide easy interface for the user to compose the conversation.

Erliza, however, instead of using same parser to matches the input conversation, generates the pattern match-based rule engines
which is better interface fot the machine. This was intended two things in mind:

- performance and efficiency in production environment
- extensible framework for actionable conversation in the future
