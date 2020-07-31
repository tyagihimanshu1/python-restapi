import re


class Utilities:

    def __init__(self):
        pass

    def replace(self,inputStr,keyWords):
        
        regex = re.compile('|'.join(map(re.escape, keyWords)))
        return regex.sub(lambda match: keyWords[match.group(0)], inputStr)