// langAssoc:: [
//   {
//     name: 'hcl',
//     fields: ['terraform', 'terragrunt', 'hcl'],
//   },
// ],
// 'package.json': {
//   language: [
//     'terraform',
//     'terragrunt',
//     'hcl',
//   ],
//   file: 'test-file.json',
// },
// langs: {

local languages = [
  {
    name: 'terraform',
    fields: ['piss', 'shit', 'bollocks'],
  },
  {
    name: 'yoyo-mc-swaggins',
    fields: ['yoyo', 'mc', 'swaggza'],
  },
];

// Create all the files here
{
  [lang.name]: {
    langauge: lang.fields,
  }
  for lang in languages;
  'something.json': {
    "hi": {
      "your-mother": 10
    }
  }
}
