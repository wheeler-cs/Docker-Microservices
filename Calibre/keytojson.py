import json
import os
import pathlib

ADEPT_KEY = "/tmp/adobekey.der"
CALIBRE_JSON = "/etc/calibre/plugins/dedrm.json"

conf = None
if pathlib.Path(CALIBRE_JSON).exists():
    conf = json.loads(pathlib.Path(
        CALIBRE_JSON).read_text(encoding="utf-8-sig"))
else:
    os.mknod(CALIBRE_JSON)
    conf = json.loads("{}")
if not isinstance(conf, str):
    conf.setdefault("adeptkeys", {})["my_ade_key"] = pathlib.Path(
        ADEPT_KEY).read_bytes().hex()
    pathlib.Path(CALIBRE_JSON).write_text(
        json.dumps(conf, indent=2), encoding="utf-8")
