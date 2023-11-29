/* ========================================================================== */
/*  Exco mobile JS content, JSEvents.js                                       */
/* ========================================================================== */
function events_load() {
    
    window.addEventListener('message', event => {
        if (event.data.type === 'exco-event') {
            window.webkit.messageHandlers.handler_events.postMessage(event.data);
        }
    });
}
events_load()
//addLoadWindowEvent(events_load);
