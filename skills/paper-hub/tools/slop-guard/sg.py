"""Run slop-guard's CLI from the cloned source without installing it."""
import importlib.metadata as m, os, sys
_v = m.version
m.version = lambda n: "0.0.0-src" if n == "slop-guard" else _v(n)
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "slop-guard", "src"))
from slop_guard.apps.cli import main
sys.exit(main())
