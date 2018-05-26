git:
  pkg.installed:
    - name: git
  group.present:
    - name: git
    - gid: 917
  user.present:
    - name: git
    - fullname: Git
    - shell: /usr/bin/git-shell
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
