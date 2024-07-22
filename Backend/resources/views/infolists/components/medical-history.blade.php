@push('head')
<script src="https://cdn.tailwindcss.com"></script>
@endpush

<div class="container mx-auto p-4 w-full">
    <div class="bg-white shadow overflow-hidden sm:rounded-lg w-full">
        <div class="px-4 py-5 sm:px-6">
            <h3 class="text-lg leading-6 font-medium text-gray-900">Medical Histories</h3>
        </div>
        <div class="border-t border-gray-200">
            <table class="min-w-full divide-y divide-gray-200 w-full">
                <thead class="bg-gray-50">
                    <tr>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                            Visit Date
                        </th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                            Diagnosis
                        </th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                            Treatment
                        </th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                            Follow-up Date
                        </th>
                        <th scope="col" class="relative px-6 py-3">
                            <span class="sr-only">View Prescriptions</span>
                        </th>
                    </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200">
                    @foreach ($medical_histories as $history)
                        <tr>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">{{ $history->visit_date }}</td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">{{ $history->diagnosis }}</td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">{{ $history->treatment }}</td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">{{ $history->follow_up_date }}</td>
                            <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                <button onclick="togglePrescriptions({{ $history->id }})" class="text-indigo-600 hover:text-indigo-900">View Prescriptions</button>
                            </td>
                        </tr>
                        <tr id="prescriptions-{{ $history->id }}" class="hidden">
                            <td colspan="5" class="px-6 py-4 whitespace-nowrap text-sm text-gray-900 bg-gray-50">
                                <div class="p-4 bg-white rounded shadow-md w-full">
                                    <div class="mb-4">
                                        <h4 class="text-sm font-medium text-gray-900">Note</h4>
                                        <p class="text-sm text-gray-700">{{ $history->note }}</p>
                                    </div>
                                    <table class="min-w-full divide-y divide-gray-200 w-full">
                                        <thead class="bg-gray-50">
                                            <tr>
                                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider w-1/12">
                                                    Medicine Name
                                                </th>
                                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider w-7/12">
                                                    Description
                                                </th>
                                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider w-1/12">
                                                    Duration
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody class="bg-white divide-y divide-gray-200">
                                            @foreach ($history->prescription as $prescription)
                                                <tr>
                                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900 w-1/12">{{ $prescription->medicine_name }}</td>
                                                    <td class="px-6 py-4 whitespace-normal text-sm text-gray-900 w-7/12">{{ $prescription->description }}</td>
                                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900 w-1/12">{{ $prescription->duration }}</td>
                                                </tr>
                                            @endforeach
                                        </tbody>
                                    </table>
                                </div>
                            </td>
                        </tr>
                    @endforeach
                </tbody>
            </table>
        </div>
    </div>
</div>

@push('scripts')
    <script>
        function togglePrescriptions(id) {
            var element = document.getElementById('prescriptions-' + id);
            if (element.classList.contains('hidden')) {
                element.classList.remove('hidden');
            } else {
                element.classList.add('hidden');
            }
        }
    </script>
@endpush
