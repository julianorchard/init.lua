local testConfig = [
  {
    name: 'test',
    body: |||
      Hello

      world$0
    |||,
  },
];

{
  'package.json': {
    name: 'julian-snippets',
    contributes: {
      snippets: [
        {
          language: [
            'terraform',
            'terragrunt',
            'hcl',
          ],
          file: 'test-file.json',
        },
      ],
    },
  },
  'test-file.json': {
    [l.name]: {
      body: std.split(l.body, '\n'),
      prefix:
        if std.objectHas(l, 'prefix') then
          l.prefix
        else l.name,
      description:
        if std.objectHas(l, 'description') then
          l.description
        else |||
          A snippet for %s
        ||| % l.name,
    }
    for l in testConfig
  },
}
