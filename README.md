{% extends "base.html" %}
{% block title %}Booking Confirmed - TravelTix{% endblock %}
{% block content %}
<div class="ticket">
  <h2>✅ Booking Confirmed</h2>
  <p class="ticket-id">Ticket ID: <strong>{{ booking['ticket_id'] }}</strong></p>
  <hr>
  <p><strong>Passenger:</strong> {{ booking['passenger_name'] }}</p>
  <p><strong>Route:</strong> {{ booking['source'] }} → {{ booking['destination'] }} ({{ booking['mode']|capitalize }})</p>
  <p><strong>Operator:</strong> {{ booking['operator'] }}</p>
  <p><strong>Departure:</strong> {{ booking['departure_time'] }} | <strong>Arrival:</strong> {{ booking['arrival_time'] }}</p>
  <p><strong>Seats:</strong> {{ booking['seats'] }}</p>
  <p><strong>Fare:</strong> ₹{{ booking['fare'] }}</p>
  <p class="muted">Booked at: {{ booking['booked_at'] }}</p>
</div>
<p><a class="btn" href="{{ url_for('home') }}">Book Another Ticket</a></p>
{% endblock %}
