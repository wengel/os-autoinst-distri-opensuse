{
  product: {
    "addons": [
         {
            "id": "PackageHub"
         }
      ],
    id: '{{AGAMA_PRODUCT_ID}}',
    registrationCode: '{{SCC_REGCODE}}'
  },
  "questions": {
      "answers": [
         {
            "answer": "Trust",
            "class": "software.import_gpg"
         }
      ],
      "policy": "auto"
  },
  software: {
    patterns: [
      'kde'
    ]
  },
  bootloader: {
    stopOnBootMenu: true,
  },
  user: {
    fullName: 'Bernhard M. Wiedemann',
    password: '$6$vYbbuJ9WMriFxGHY$gQ7shLw9ZBsRcPgo6/8KmfDvQ/lCqxW8/WnMoLCoWGdHO6Touush1nhegYfdBbXRpsQuy/FTZZeg7gQL50IbA/',
    hashedPassword: true,
    userName: 'bernhard'
  },
  root: {
    password: '$6$vYbbuJ9WMriFxGHY$gQ7shLw9ZBsRcPgo6/8KmfDvQ/lCqxW8/WnMoLCoWGdHO6Touush1nhegYfdBbXRpsQuy/FTZZeg7gQL50IbA/',
    hashedPassword: true
  },
  scripts: {
    post: [
      {
        name: 'enable sshd',
        chroot: true,
        content: |||
          #!/usr/bin/env bash
          systemctl enable sshd
        |||
      }
    ]
  }
}
