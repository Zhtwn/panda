use v6;
BEGIN { @*INC.push('lib') };
use JSON::Tiny_;
use Test;

my @t =
   '{ "a" : 1 }' => { a => 1 },
   '[]'          => [],
   '{}'          => {},
   '[ "a", "b"]' => [ "a", "b" ],
   '[3]'         => [3],
   '["\t\n"]'    => ["\t\n"],
   '[{ "foo" : { "bar" : 3 } }, 78]' => [{ foo => { bar => 3 }}, 78],
   '[{ "a" : 3, "b" : 4 }]' => [{ a => 3, b => 4}],
    Q<<{
    "glossary": {
        "title": "example glossary",
		"GlossDiv": {
            "title": "S",
			"GlossList": {
                "GlossEntry": {
                    "ID": "SGML",
					"SortAs": "SGML",
					"GlossTerm": "Standard Generalized Markup Language",
					"Acronym": "SGML",
					"Abbrev": "ISO 8879:1986",
					"GlossDef": {
                        "para": "A meta-markup language, used to create markup languages such as DocBook.",
						"GlossSeeAlso": ["GML", "XML"]
                    },
					"GlossSee": "markup"
                }
            }
        }
    }
}
    >> => {
    "glossary" => {
        "title" => "example glossary",
		"GlossDiv" => {
            "title" => "S",
			"GlossList" => {
                "GlossEntry" => {
                    "ID" => "SGML",
					"SortAs" => "SGML",
					"GlossTerm" => "Standard Generalized Markup Language",
					"Acronym" => "SGML",
					"Abbrev" => "ISO 8879:1986",
					"GlossDef" => {
                        "para" => "A meta-markup language, used to create markup languages such as DocBook.",
						"GlossSeeAlso" => ["GML", "XML"]
                    },
					"GlossSee" => "markup"
                }
            }
        }
    }
},
;
plan +@t;

for @t -> $p {
    my $s = from-json($p.key);
    say "# Got: $s\n# Expected: {$p.value.perl}";
    is_deeply $s, $p.value, 
        "Correct data structure for «{$p.key.subst(/\n/, '\n', :g)}»"
        or say "# Got: $s\n# Expected: {$p.value.perl}";
}

# vim: ft=perl6
