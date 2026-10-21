
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>AI Disaster Response Assistant | DisasterGuard AI</title>

<style>
    * { box-sizing: border-box; }

    body {
        margin: 0;
        font-family: Arial, sans-serif;
        background: #f2f5fa;
        color: #172033;
    }

    .container {
        max-width: 900px;
        margin: 30px auto;
        padding: 20px;
    }

    .header {
        background: #142b4a;
        color: white;
        padding: 24px;
        border-radius: 14px 14px 0 0;
    }

    .header h1 { margin: 0 0 8px; font-size: 25px; }
    .header p { margin: 0; color: #dbeafe; line-height: 1.5; }

    .chat-box {
        background: white;
        border: 1px solid #dce3ed;
        border-top: 0;
        border-radius: 0 0 14px 14px;
        overflow: hidden;
        box-shadow: 0 8px 25px rgba(20, 43, 74, 0.08);
    }

    #messages {
        height: 420px;
        overflow-y: auto;
        padding: 22px;
    }

    .message {
        max-width: 85%;
        padding: 13px 16px;
        border-radius: 12px;
        margin-bottom: 15px;
        line-height: 1.6;
        white-space: pre-wrap;
        overflow-wrap: anywhere;
    }

    .bot {
        background: #edf4ff;
        border: 1px solid #d7e6ff;
        margin-right: auto;
    }

    .user {
        background: #1764d8;
        color: white;
        margin-left: auto;
    }

    .suggestions {
        display: flex;
        flex-wrap: wrap;
        gap: 8px;
        padding: 0 20px 16px;
    }

    .suggestions button {
        background: white;
        border: 1px solid #cbd5e1;
        padding: 9px 12px;
        border-radius: 20px;
        cursor: pointer;
    }

    .suggestions button:hover { background: #edf4ff; }

    .input-area {
        display: flex;
        gap: 10px;
        padding: 16px;
        border-top: 1px solid #e2e8f0;
    }

    #question {
        flex: 1;
        min-width: 0;
        padding: 13px;
        border: 1px solid #cbd5e1;
        border-radius: 9px;
        font-size: 15px;
    }

    #send {
        padding: 12px 20px;
        background: #1764d8;
        color: white;
        border: 0;
        border-radius: 9px;
        cursor: pointer;
    }

    #send:disabled { opacity: 0.6; cursor: wait; }

    .notice {
        padding: 13px 18px;
        background: #fff8e6;
        color: #704c00;
        font-size: 12px;
        line-height: 1.5;
    }

    .navigation {
        display: inline-block;
        margin-bottom: 15px;
        color: #1764d8;
        text-decoration: none;
    }

    @media (max-width: 600px) {
        .container { margin: 8px auto; padding: 10px; }
        #messages { height: 55vh; }
        .message { max-width: 95%; }
        .input-area { padding: 10px; }
        #send { padding: 10px 13px; }
    }
</style>
</head>

<body>
<div class="container">

    <a class="navigation"
       href="<%= request.getContextPath() %>/dashboard.jsp">
       &#8592; Back to Dashboard
    </a>

    <div class="header">
        <h1>&#129302; AI Disaster Response Assistant</h1>
        <p>Ask questions about disaster preparedness and emergency safety.</p>
    </div>

    <div class="chat-box">
        <div id="messages" aria-live="polite">
            <div class="message bot">Hello! I'm your DisasterGuard AI safety assistant.

I can help with floods, earthquakes, fires, cyclones, landslides, heatwaves, and emergency preparedness.

What would you like to know?</div>
        </div>

        <div class="suggestions">
            <button type="button" data-question="What should I do during a flood?">Flood safety</button>
            <button type="button" data-question="How do I stay safe during an earthquake?">Earthquake safety</button>
            <button type="button" data-question="What should I keep in an emergency kit?">Emergency kit</button>
            <button type="button" data-question="How can I stay safe during a cyclone?">Cyclone safety</button>
        </div>

        <form id="chatForm" class="input-area">
            <input id="question" name="question" type="text"
                   maxlength="2000" placeholder="Ask your disaster safety question..."
                   autocomplete="off" required>
            <button id="send" type="submit">Send</button>
        </form>

        <div class="notice">
            Safety notice: This AI may make mistakes and does not provide verified
            live emergency alerts. Follow official instructions. In India, call
            112 for emergency assistance when needed.
        </div>
    </div>
</div>

<script>
    const contextPath = '<%= request.getContextPath() %>';
    const messages = document.getElementById('messages');
    const form = document.getElementById('chatForm');
    const questionInput = document.getElementById('question');
    const sendButton = document.getElementById('send');

    function addMessage(text, type) {
        const bubble = document.createElement('div');
        bubble.className = 'message ' + type;

        // Treat responses as text, not HTML.
        bubble.textContent = text;

        messages.appendChild(bubble);
        messages.scrollTop = messages.scrollHeight;
        return bubble;
    }

    async function sendQuestion(question) {
        question = question.trim();

        if (!question || sendButton.disabled) return;

        addMessage(question, 'user');
        questionInput.value = '';
        sendButton.disabled = true;
        questionInput.disabled = true;

        const waiting = addMessage('Thinking...', 'bot');

        try {
            const body = new URLSearchParams();
            body.set('question', question);

            const response = await fetch(
                contextPath + '/AIDisasterAssistantServlet',
                {
                    method: 'POST',
                    headers: {
                        'Content-Type':
                            'application/x-www-form-urlencoded;charset=UTF-8'
                    },
                    body: body.toString()
                }
            );

            const answer = await response.text();

            if (!response.ok) {
                throw new Error(answer || 'Request failed. Please try again.');
            }

            waiting.textContent = answer;
        } catch (error) {
            waiting.textContent =
                'Sorry, I could not contact the AI assistant. '
                + 'Please check your connection and try again.';
            console.error('Chat request failed:', error);
        } finally {
            sendButton.disabled = false;
            questionInput.disabled = false;
            questionInput.focus();
            messages.scrollTop = messages.scrollHeight;
        }
    }

    form.addEventListener('submit', function(event) {
        event.preventDefault();
        sendQuestion(questionInput.value);
    });

    document.querySelectorAll('.suggestions button').forEach(function(button) {
        button.addEventListener('click', function() {
            sendQuestion(button.dataset.question);
        });
    });
</script>
</body>
</html>
