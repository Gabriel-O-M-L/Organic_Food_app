import json
from datetime import datetime

import jwt


# request.META.get('HTTP_AUTHORIZATION', None)
def decode(token):
    try:
        decrypted_token = jwt.decode(
            token,
            key='askdasdiuh123i1y98yejas9d812hiu89dqw9',
            algorithms='HS256'
        ) if token is not None else None

        if decrypted_token is not None and decrypted_token.get('exp') > datetime.now().timestamp() * 1000:
            return {
                'valid': True
            }
        else:
            return {
                'valid': False
            }

    except:
        return {
            'valid': False
        }


def encode(exp, id_user):
    key = 'askdasdiuh123i1y98yejas9d812hiu89dqw9'
    encoded_jwt = jwt.encode({
        'exp': exp,
        "id_user": id_user
    },
        key,
        algorithm='HS256')

    return encoded_jwt
