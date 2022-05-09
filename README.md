# InvoiceLogger

This is a small application that allows users to create invoices and save them locally.

The artchitecture of the app is MVVM and it uses coordinators for navigation. 

There are three pages in the application, one containing the invoices table, one showing the details of any selected invoice, and one allowing users to create new invoices.
The app uses CoreData to save and retrieve invoices on the device.

**Limitations**

Due to time limitations, the following are not supported:
- Long titles and locations
- Editing invoices
- Deleting invoices
- Adding multiple photos for the same invoice
- Getting to see the image in full size when tapping on it
- Only a few currencies are supported
- Strings are not localized and are hardcoded where needed


**Nice to have**

Additionally to the limitations, it would have been nice to have the following:
- A profile page
      - where the user could turn on reminders to add photos for invoices missing it
      - set allowed currencies
      - turn on saving images in the photo gallery
- Organizing the table view by days, where all inputs for the same day are shown within one section
- Single entity or enum that takes care of strings and localizations
