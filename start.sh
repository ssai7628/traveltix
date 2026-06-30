{% extends "base.html" %}
{% block title %}TravelTix - Book Bus & Train Tickets{% endblock %}
{% block content %}
<section class="hero">
  <h1>Book Bus & Train Tickets</h1>
  <p>Fast, simple ticket booking. Site by {{ owner }}.</p>
</section>

<form class="search-form" action="{{ url_for('search') }}" method="get">
  <div class="field">
    <label>Mode</label>
    <select name="mode">
      <option value="">Any</option>
      <option value="bus">Bus</option>
      <option value="train">Train</option>
    </select>
  </div>
  <div class="field">
    <label>From</label>
    <input type="text" name="source" placeholder="e.g. Chennai">
  </div>
  <div class="field">
    <label>To</label>
    <input type="text" name="destination" placeholder="e.g. Bengaluru">
  </div>
  <button type="submit">Search</button>
</form>

<section class="info-cards">
  <div class="card"><h3>🎟️ Easy Booking</h3><p>Search, pick a route, and book in under a minute.</p></div>
  <div class="card"><h3>⚡ Fast Backend</h3><p>Python handles the site; a Java microservice computes fares & ticket IDs.</p></div>
  <div class="card"><h3>📩 Instant Confirmation</h3><p>Get your ticket ID and details immediately after booking.</p></div>
</section>
{% endblock %}
