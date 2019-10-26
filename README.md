# erliza
Yet another Erlang Eliza, natural language processing conversation program, focused on performance 
and extensible conversation composition.

The original lexer and parser credit goes to https://github.com/edinhui/eliza.git. Unlike other many eliza implementations,
having parser for script provides easy user interface to compose and modify the conversations.

Erliza, however, instead of using same parser to process the dialog input, generates the pattern match-based rule engine
which is better interface for the machine perspective. This architecture was intended two things in mind:

- performance and efficiency in production environment
- extensible framework for actionable conversation in the future
