## Folder contents

Roles folder. Contains the various independent roles for the playbook. 
```
./roles/
├── build_solid_image
│   ├── defaults
│   └── tasks
├── docker
│   └── tasks
├── general
│   ├── tasks
│   └── vars
├── get_solid
│   ├── defaults
│   ├── files
│   └── tasks
├── nodejs
│   ├── defaults
│   ├── tasks
│   └── templates
├── python
│   ├── tasks
│   └── vars
└── README.md

19 directories, 1 file

```

## Deployment

Each role can be run individually by running the playbook with the appropriate tags.
```
ansible-playbook MainPlaybook.yml --tags "python"
```
Or the playbook can be run in it's entirety while excluding certaign tags.
```
ansible-playbook MainPlaybook.yml --skip-tags "python"
```
