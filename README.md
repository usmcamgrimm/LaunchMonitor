# Launch Monitor 🚀

> **Never miss an upcoming launch.**

Track upcoming rocket launches in real time, powered by live data from the Space Devs API.

🌐 Deployed and hosted on [Fly.io](https://fly.io/).

## About

Launch Monitor pulls upcoming launch data from the [Space Devs API](https://thespacedevs.com/) and presents it in a clean, easy-to-browse interface. Whether you're a space enthusiast or just curious about what's launching next, this app keeps you in the loop.

---

## Built With

| Technology | Version |
|---|---|
| [Ruby](https://www.ruby-lang.org/) | 3.4.9 |
| [Ruby on Rails](https://rubyonrails.org/) | ~> 8.1 |
| [SQLite](https://www.sqlite.org/) | ~> 2.9 |
| [Tailwind CSS](https://tailwindcss.com/) | via tailwindcss-rails |
| [HTTParty](https://github.com/jnunemaker/httparty) | ~> 0.24.2 |

**HTTParty** is used to query the [Space Devs Launch Library 2 API](https://ll.thespacedevs.com/docs/).

## Environment variables
| Variable | Default | Purpose |
| --- | --- | --- |
| `SPACE_DEVS_BASE_URI` | `https://ll.thespacedevs.com/2.3.0/launches/upcoming/` | TheSpaceDevs API base. Use `https://lldev.thespacedevs.com/2.2.0/launch/upcoming/` for local/dev. |
---