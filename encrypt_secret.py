#!/usr/bin/env python3

import sys
import argparse
from base64 import b64encode
from nacl import encoding, public

def encrypt(public_key: str, secret_value: str) -> str:
    """Encrypt a Unicode string using the public key."""
    public_key = public.PublicKey(public_key.encode("utf-8"), encoding.Base64Encoder())
    sealed_box = public.SealedBox(public_key)
    encrypted = sealed_box.encrypt(secret_value.encode("utf-8"))
    return b64encode(encrypted).decode("utf-8")


# Create an ArgumentParser object
parser = argparse.ArgumentParser()

# Add the arguments
parser.add_argument("public_key", help="public_key")
parser.add_argument("secret_value", help="secret_value")

# Parse the arguments
args = parser.parse_args()

# Check if the arguments are not set
if not args.public_key or not args.secret_value:
    parser.print_help(sys.stderr)
    sys.exit(1)

if __name__ == "__main__":
    print(encrypt(args.public_key,args.secret_value))