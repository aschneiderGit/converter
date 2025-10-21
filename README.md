# Converter

A **Flutter** application that allows users to convert currencies **offline**.  
The app retrieves fresh exchange rates from a free API (no authentication required) and stores them locally using **SQLite** for offline access.

---

## Features

- **Currency conversion** with real-time rates
- **Offline mode** — conversions work without internet
- **Automatic data refresh** — exchange rates are refreshed once per day
- **Local database** using **SQLite** for storing exchange rates

---

## How It Works

1. On first launch, the app fetches exchange rates from [ExchangeRate API Free](https://www.exchangerate-api.com/).
2. The data is saved in a local **SQLite** database.
3. When offline, conversions use the stored rates.
4. Once per day, the app refreshes rates automatically if a connection is available.
