from passlib.hash import sha256_crypt

def hash_password(password):
	"""
	Function to encrypt a password
	"""
	return sha256_crypt.encrypt(password)

def check_password(password, encrypted_password):
	"""
	Returns True if entered password matches encrypted password
	"""
	return sha256_crypt.verify(password, encrypted_password)

if __name__ == "__main__":

	hashed_password = hash_password("p@ssw0rd")

	print(check_password("p@ssw0rd", hashed_password))