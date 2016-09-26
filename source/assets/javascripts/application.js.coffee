# Dynamically load scripts
((doc, script) ->
  window.loadScript = (src, id, callback = ->) ->
    return if doc.getElementById(id)
    s       = doc.createElement("script")
    s.type  = "text/" + (src.type or "javascript")
    s.src   = src.src or src
    s.async = false
    s.id    = id
    s.onreadystatechange = s.onload = ->
      state = s.readyState
      if not callback.done and (not state or /loaded|complete/.test(state))
        callback.done = true
        callback()
    # use body if available. more safe in IE
    (doc.body or head).appendChild s
) document, "script"

# loadScript "//connect.facebook.net/de_DE/sdk.js#xfbml=1&version=v2.7", "facebook-jssdk"
# loadScript "//platform.twitter.com/widgets.js", "twitter-wjs"
