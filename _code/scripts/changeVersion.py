

import ruamel.yaml #이 라이브러리가 주석과 순서를 보존해준다.

yaml = ruamel.yaml.YAML()
yaml.indent(mapping=4, sequence=4, offset=2)
yaml.preserve_quotes = True #''를 없애는걸 방지한다.

with open('../pubspec.yaml') as f:
    yamlMap = yaml.load(f)

with open('../pubspec.yaml', 'w') as f:
    fullVersion:str = yamlMap["version"]
    yamlMap["version"] = (fullVersion.split('+'))[0]+"+"+str(int((fullVersion.split('+'))[1])+1)
    yaml.dump(yamlMap, f)

    print(f'----------------{yamlMap["version"]} 버전입니다.')