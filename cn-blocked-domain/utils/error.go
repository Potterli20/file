package utils

// Must panics runtime error
func Must(err error) {
	if err != nil {
		panic(err)
	}
}

func Must2(v any, err error) any {
	if err != nil {
		panic(err)
	}
	return v
}
