# FAQ

## Is Parley client-side or server-side?

Both. The runtime runs on the server and sends steps to the client UI through remote events.

## Can I run Parley without WebUI?

Yes. Provide a custom UI adapter and skip the client bridge entirely.

## Does Parley support localization?

Not built-in. You can implement `Parley.SetTextResolver` to route text through your localization system.

## Can I parse multiple dialogue files?

Yes. Call `Parley.Load` for each file and keep the returned assets (or cache them by id).

