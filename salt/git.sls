git:
  pkg.installed:
    - name: git
  group.present:
    - name: git
    - gid: 917
  user.present:
    - name: git
    - fullname: Git
    # TODO: Examine whether to make shell /bin/nologin
    - shell: /bin/bash
    - home: /home/git
    - uid: 917
    - gid: 917
    - require:
      - group: git
  ssh_auth.present:
    - user: git
    - source: salt://authorized_keys
    - require:
      - user: git
