{% extends "base.html" %}
{% block title %}Book Ticket - TravelTix{% endblock %}
{% block content %}
<h2>Book: {{ route['source'] }} → {{ route['destination'] }}</h2>
<p class="muted">{{ route['operator'] }} · {{ route['mode']|capitalize }} · Departs {{ route['departure_time'] }} · {{ route['distance_km'] }} km</p>

<form class="booking-form" method="post">
  <div class="field">
    <label>Full Name</label>
    <input type="text" name="name" required>
  </div>
  <div class="field">
    <label>Email</label>
    <input type="email" name="email" required>
  </div>
  <div class="field">
    <label>Phone</label>
    <input type="tel" name="phone" required>
  </div>
  <div class="field">
    <label>Seats</label>
    <input type="number" name="seats" min="1" max="{{ route['seats_available'] }}" value="1" required>
  </div>
  <button type="submit">Confirm Booking</button>
</form>
{% endblock %}
