# Lab 11 — Notes

## Part 1: Setup and First Request

### 1. Identify JSON field types in `product.json`

Using the response from `https://dummyjson.com/products/1`:

- **Number:** `price` — for example, `9.99`.
- **List of strings:** `tags` — contains product tags.
- **Nested object:** `dimensions` — contains `width`, `height`, and `depth`.
- **List of objects:** `reviews` — contains multiple review objects.

### 2. What happens when the address is changed to `/products/0`?

The API returns HTTP status code **404 (Not Found)** because product ID `0` does not exist.

The response contains an error message indicating that the product was not found.

## Part 2: Models from JSON

### 1. What happens if we write `json['price'] as double` and the server sends `10`?

Dart decodes the JSON number `10` as an `int`, not a `double`.

Casting it directly using `as double` causes a `TypeError` at runtime, not at compile time.

The correct approach is:

```dart
(json['price'] as num).toDouble()
```

This handles both integer and double values.

### 2. Why is it better to test `fromJson` with a saved file than with a live request?

A saved JSON file makes the test deterministic and independent of the internet connection or API availability.

It also ensures that the same input is used every time, making parsing errors easier to reproduce and debug.

### 3. What happens when `brand` and `tags` are missing?

- **Brand:** The model uses `String?` and `json['brand'] as String?`, so a missing brand becomes `null` without causing an error.
- **Tags:** The current implementation uses `(json['tags'] as List).cast<String>()`. If the `tags` key is missing, it causes a `TypeError` because the model expects a list.

This behavior is confirmed by the model tests.
