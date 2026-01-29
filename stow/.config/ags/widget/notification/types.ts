/** Props for the shared notification card component.
 *  Reactive values (from createPoll accessors) are typed as `any`
 *  to match AGS's Accessor interface without importing internals. */
export interface NotificationItemProps {
  appIcon: any
  summary: any
  time: any
  body: any
  visible?: any
  onDismiss: () => void
  className?: string
}
