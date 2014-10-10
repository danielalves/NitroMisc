1.1.0
-----

- Fixing -invocationForSelector:WithTarget: - must accept classes as target, not only NSObjects
- Adding +invokeSelector:onTarget:withArguments:returnValue: NSInvocation utility method

1.0.2
-----

- Fixing `SYNTHESIZE_SINGLETON_FOR_CLASS` macro: must not create a dealloc method, because users may want to do so

1.0.1
-----

- Fixing `Podfile`

1.0.0
-----

- Initial version
